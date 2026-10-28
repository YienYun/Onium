-- Script path: ReplicatedStorage.Shared.Util.ToolHolders
-- Decompile time: 3.53 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = require(ReplicatedStorage.Shared.Player)
local v1 = {
    FromTool = function(a1) -- Line: 20 -- upvalues: Players (val) -- types: a1: userdata
        local v1 = false
        if typeof(a1) == "Instance" then
            v1 = a1:IsA("Tool")
        end
        assert(v1, "FromTool expects a Tool")
        local Parent = a1.Parent
        if Parent == nil then
            return nil
        end
        if Parent:IsA("Player") then
            return Parent
        end
        if Parent:IsA("Model") then
            return (Players:GetPlayerFromCharacter(Parent))
        end
        return nil
    end,
}

local function riderRise(a1) -- Line: 32 -- types: a1: userdata
    local PetMountSession = a1:FindFirstChild("PetMountSession")
    local Attribute = PetMountSession and PetMountSession:GetAttribute("HeightIncrease")
    if typeof(Attribute) == "number" and Attribute > 0 then
        return Attribute
    end
    return 0
end

local function reachDistance(a1, a2, a3) -- Line: 38 -- types: a1: vector, a2: vector, a3: number
    local Magnitude = (a2 - a1).Magnitude
    if a3 <= 0 then
        return Magnitude
    end
    return (math.min(Magnitude, (a2 - (Vector3.new(0, a3, 0)) - a1).Magnitude))
end

local function survey(a1, a2, a3) -- Line: 46
    -- upvalues: Players (val), Player (val)
    local Attribute, Magnitude, PetMountSession, Position, v1, v2, v3, v4, v5
    local v6 = {}
    local v7, v8, v9 = a1, a2, a3
    for i, j in Players:GetPlayers() do
        if j ~= v7 then
            v5 = Player.FindRootPart(j)
            if v5 ~= nil then
                v1 = v5.Position - v8
                v2 = Player.FindCharacter(j)
                Position = v5.Position
                if not v2 then
                    v4 = 0
                else
                    PetMountSession = v2:FindFirstChild("PetMountSession")
                    Attribute = PetMountSession and PetMountSession:GetAttribute("HeightIncrease")
                    v4 = if typeof(Attribute) ~= "number" then 0 else if not (Attribute > 0) then 0 else Attribute
                end
                Magnitude = (Position - v8).Magnitude
                v3 = if not (v4 <= 0) then math.min(Magnitude, (Position - (Vector3.new(0, v4, 0)) - v8).Magnitude) else Magnitude
                if v3 <= v9 then
                    table.insert(v6, {player = j, delta = v1, distance = v3})
                end
            end
        end
    end
    table.sort(v6, function(a1, a2) -- Line: 63 -- types: a1: table, a2: table
        return a1.distance < a2.distance
    end)
    return v6
end

function v1.NearestWithin(a1, a2, a3) -- Line: 71
    -- upvalues: Player (val), survey (val)
    local v1 = false
    if typeof(a1) == "Instance" then
        v1 = a1:IsA("Player")
    end
    assert(v1, "NearestWithin expects a Player")
    assert(type(a2) == "number", "NearestWithin expects a numeric range")
    local v2 = Player.FindRootPart(a1)
    if v2 == nil then
        return nil, (Vector3.new(1, 0, 0))
    end
    v1 = survey(a1, v2.Position, a2)
    v2 = if a3 ~= nil then math.max(0, (math.floor(a3))) else 1
    if v2 > 1 then
        return table.move(v1, 1, math.min(v2, #v1), 1, {})
    end
    v2 = v1[1]
    if v2 == nil then
        return nil, (Vector3.new(1, 0, 0))
    end
    return v2.player, v2.delta
end

return table.freeze(v1)