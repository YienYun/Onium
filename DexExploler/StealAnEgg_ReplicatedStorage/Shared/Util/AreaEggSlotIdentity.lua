-- Script path: ReplicatedStorage.Shared.Util.AreaEggSlotIdentity
-- Decompile time: 3.75 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u14 = t.strict(t.instanceIsA("Model"))
local u17 = t.strict(t.string)
local u18 = {}

local function rankOf(a1) -- Line: 35 -- types: a1: userdata
    local EggSpotBottom = a1.EggSpotBottom
    assert(EggSpotBottom:IsA("BasePart"), (("%* is missing its EggSpotBottom marker"):format((a1:GetFullName()))))
    local Position = EggSpotBottom.Position
    return {
        model = a1,
        grid = {
            math.round(Position.X * 1000),
            math.round(Position.Z * 1000),
            (math.round(Position.Y * 1000)),
        },
        label = a1.Name,
    }
end

local function precedes(a1, a2) -- Line: 51 -- types: a1: table, a2: table
    for i = 1, 3 do
        if a1.grid[i] ~= a2.grid[i] then
            return a1.grid[i] < a2.grid[i]
        end
    end
    return a1.label < a2.label
end

local function isEventNest(a1) -- Line: 60 -- types: a1: userdata
    return a1:GetAttribute("EventNestId") ~= nil
end

function u18.SortedNests(a1) -- Line: 64 -- upvalues: u14 (val), rankOf (val), precedes (val) -- types: a1: userdata
    u14(a1)
    local Nests = a1.Nests
    local v1 = ("%* must keep its nests in a Folder or a Model"):format((a1:GetFullName()))
    assert(Nests:IsA("Folder") or Nests:IsA("Model"), v1)
    local v2 = {}
    for i, j in Nests:GetChildren() do
        if j:IsA("Model") and not (j:GetAttribute("EventNestId") ~= nil) then
            table.insert(v2, (rankOf(j)))
        end
    end
    table.sort(v2, precedes)
    local v3 = table.create(#v2)
    for k, n in v2 do
        v3[k] = n.model
    end
    return v3
end

function u18.NestIdFor(a1, a2) -- Line: 88 -- upvalues: u14 (val), u18 (val) -- types: a1: userdata, a2: userdata
    u14(a1)
    u14(a2)
    local v1 = table.find(u18.SortedNests(a1), a2)
    if v1 == nil then
        error((("%* does not sit under %*"):format(a2:GetFullName(), (a1:GetFullName()))))
    end
    return string.format("Slot_%03d", v1)
end

function u18.NestFor(a1, a2) -- Line: 99 -- upvalues: u14 (val), u17 (val), u18 (val) -- types: a1: userdata, a2: string
    u14(a1)
    u17(a2)
    local v1 = string.match(a2, "^Slot_(%d+)$")
    local v2 = ("%* does not name a nest slot"):format(a2)
    assert(v1 ~= nil, v2)
    local v3 = tonumber(v1)
    local v4 = ("%* carries a slot number that will not parse"):format(a2)
    assert(v3 ~= nil, v4)
    v1 = u18.SortedNests(a1)[v3]
    v4 = ("%* has nothing at slot %*"):format(a1.Name, a2)
    assert(v1 ~= nil, v4)
    return v1
end

function u18.MarkEventNest(a1, a2) -- Line: 113 -- upvalues: u14 (val), u17 (val) -- types: a1: userdata, a2: string
    u14(a1)
    u17(a2)
    assert(a1.Parent == nil, "Mark event nests before parenting them")
    local v1 = ("EventNest_%*"):format(a2)
    a1:SetAttribute("EventNestId", v1)
    return v1
end

function u18.LooksLikeEventNestId(a1) -- Line: 123 -- upvalues: u17 (val) -- types: a1: string
    u17(a1)
    return string.find(a1, "EventNest_", 1, true) == 1
end

function u18.SlotKey(a1, a2) -- Line: 128 -- upvalues: u17 (val) -- types: a1: string, a2: string
    u17(a1)
    u17(a2)
    return string.format("%s:%s", a1, a2)
end

function u18.LooksLikeFirstAreaUid(a1) -- Line: 135 -- upvalues: u17 (val) -- types: a1: string
    u17(a1)
    return string.find(a1, "FirstAreaEgg_", 1, true) == 1
end

function u18.FirstAreaOwnerUserId(a1) -- Line: 140 -- upvalues: u17 (val) -- types: a1: string
    u17(a1)
    local v1 = string.match(a1, "^FirstAreaEgg_(-?%d+)_")
    if v1 ~= nil then
        return (tonumber(v1))
    end
    return nil
end

return table.freeze(u18)