-- Script path: ReplicatedStorage.Shared.FusionShrines
-- Decompile time: 5.85 ms

local v1, v2, v3
local u115 = {}
local u117 = {}
local v4 = {}
for i, j in script:GetChildren() do
    if j:IsA("ModuleScript") then
        v3 = require(j)
        assert(v3.Id == j.Name, (("FusionShrines.%* must have Id \"%*\""):format(j.Name, j.Name)))
        assert(#v3.Sides >= 2, (("FusionShrines.%* needs at least two sides"):format(j.Name)))
        u115[v3.Id] = v3
        v1 = nil
        v2 = nil
        for k, n in v3.Tiers, v1, v2 do
            assert(u117[n] == nil, (("Fusion tier %* is claimed by two shrines"):format(n)))
            u117[n] = v3
            table.insert(v4, n)
        end
    end
end
table.sort(v4)
local u20 = {Default = "LightDark"}
u20.Tiers = table.freeze(v4)

function u20.Get(a1) -- Line: 84 -- upvalues: u115 (val)
    return u115[if type(a1) ~= "string" then "LightDark" else a1]
end

function u20.Of(a1) -- Line: 88 -- upvalues: u20 (val) -- types: a1: userdata
    return u20.Get(a1:GetAttribute("FusionShrine") or "LightDark")
end

function u20.KindOfTier(a1) -- Line: 92 -- upvalues: u117 (val) -- types: a1: string
    return u117[a1]
end

function u20.PadsOf(a1, a2) -- Line: 96 -- types: a1: userdata, a2: table
    local v1
    local v2 = {}
    for i, j in a2.Sides do
        v1 = a1:FindFirstChild(a2.Pads[j])
        if v1 and v1:IsA("BasePart") then
            v2[j] = v1
            continue
        end
        return nil
    end
    return v2
end

function u20.SlotsOf(a1, a2) -- Line: 108 -- types: a1: userdata, a2: table
    local v1
    local Placement = a2.Placement
    if not Placement then
        return nil
    end
    local v2 = {}
    for i, j in Placement.Slots do
        v1 = a1:FindFirstChild(i)
        if v1 and v1:IsA("BasePart") then
            table.insert(v2, {Name = i, Side = j, Pad = v1})
            continue
        end
        return nil
    end
    table.sort(v2, function(a1, a2) -- Line: 121
        return a1.Name < a2.Name
    end)
    return v2
end

function u20.SeatOf(a1, a2) -- Line: 127 -- types: a1: table, a2: string
    local Placement = a1.Placement
    if not Placement then
        return nil
    end
    for i, j in Placement.Seats do
        if table.find(j, a2) then
            return i
        end
    end
    return nil
end

function u20.Claim(a1, a2, a3, a4, a5) -- Line: 140
    -- upvalues: u20 (val)
    local v1 = u20.SeatOf(a1, a5)
    local v2 = {}
    local v3 = nil
    for i, j in a2 do
        if j == a4 then
            v2[a3[i]] = true
            v3 = u20.SeatOf(a1, i)
        elseif u20.SeatOf(a1, i) == v1 then
            return "Taken", nil
        end
    end
    if v2[a3[a5]] then
        for m, i5 in a1.Sides do
            if not v2[i5] then
                return "Partner", i5
            end
        end
        return "Partner", nil
    end
    if v3 ~= nil and v3 ~= v1 then
        for k, n in a1.Sides do
            if not v2[n] then
                return "Partner", n
            end
        end
        return "Partner", nil
    end
    return "Open", nil
end

function u20.PairSlots(a1, a2) -- Line: 169 -- types: a1: table, a2: table
    local Side, v1, v2, v3, v4, v5, v6, v7, v8, v9
    local Placement = a2.Placement
    if Placement and Placement.Seats then
        local v10, v11
        v5 = {}
        for i, j in a1 do
            v5[j.Name] = j
        end
        v6 = {}
        v7 = nil
        v8 = nil
        for k, n in Placement.Seats, v7, v8 do
            v10 = {}
            for m, i5 in n do
                v11 = v5[i5]
                if v11 then
                    v10[v11.Side] = v11.Pad
                end
            end
            table.insert(v6, v10)
        end
        return v6
    end
    local v12 = {}
    v6 = nil
    local v13 = nil
    local v14 = a2
    for i6, i7 in a1, v6, v13 do
        Side = i7.Side
        v9 = v12[i7.Side] or {}
        v12[Side] = v9
        table.insert(v12[i7.Side], i7)
    end
    v5 = v14.Sides[1]
    v6 = v14.Sides[2]
    v13 = {}
    v7 = {}
    v8 = v12[v5] or {}
    local v15 = nil
    v9 = nil
    for i8, i9 in v8, v15, v9 do
        v1 = nil
        v2 = v12[v6] or {}
        v3 = nil
        v4 = nil
        for i10, i11 in v2, v3, v4 do
            if not v13[i11] then
                if v1 == nil
                    or (i11.Pad.Position - i9.Pad.Position).Magnitude < (v1.Pad.Position - i9.Pad.Position).Magnitude then
                    v1 = i11
                end
            end
        end
        if v1 then
            v13[v1] = true
            v4 = {}
            v4[v5] = i9.Pad
            v4[v6] = v1.Pad
            table.insert(v7, v4)
        end
    end
    return v7
end

function u20.Others(a1, a2) -- Line: 219 -- types: a1: table, a2: string
    local v1 = {}
    for i, j in a1.Sides do
        if j ~= a2 then
            table.insert(v1, j)
        end
    end
    return v1
end

return table.freeze(u20)