-- Script path: ReplicatedStorage.Client.SmartProximityPrompt.FollowerLoop
-- Decompile time: 6.24 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = require(ReplicatedStorage.Shared.Player)
require(script.Parent.SurfaceTracker)
local u25 = {
    Size = Vector3.new(1, 1, 1),
    Transparency = 1,
    Anchored = true,
    CanCollide = false,
    CanTouch = false,
    CanQuery = false,
}
local u26 = {}
local LocalPlayer = Players.LocalPlayer
local u28 = {}
local u29 = nil
local u30 = 0

local function stopPulseIfIdle() -- Line: 49 -- upvalues: u28 (val), u29 (ref)
    if next(u28) == nil and u29 ~= nil then
        u29:Disconnect()
        u29 = nil
        return
    end
end

local function chase(a1, a2, a3) -- Line: 58 -- types: a1: table, a2: vector, a3: number
    local ClosestSurfacePoint, ClosestSurfacePoint_2 = a1.tracker:GetClosestSurfacePoint(a2, a1.standoff, a1.range)
    if ClosestSurfacePoint ~= nil and ClosestSurfacePoint_2 ~= nil and not (a1.range < ClosestSurfacePoint_2) then
        local v1 = if not (a1.range < (a1.anchor.Position - ClosestSurfacePoint).Magnitude) then math.clamp(a3 * a1.rate, 0, 1) else 1
        a1.anchor.CFrame = CFrame.new(a1.anchor.Position:Lerp(ClosestSurfacePoint, v1))
        return
    end
    a1.anchor.CFrame = a1.model:GetPivot()
end

local function dropFollower(a1, a2) -- Line: 70 -- upvalues: u28 (val), u29 (ref) -- types: a1: userdata, a2: number?
    local v1 = u28[a1]
    if v1 == nil then
        return
    end
    if a2 ~= nil and v1.id ~= a2 then
        return
    end
    u28[a1] = nil
    for i, j in v1.connections do
        j:Disconnect()
    end
    table.clear(v1.connections)
    if next(u28) == nil and u29 ~= nil then
        u29:Disconnect()
        u29 = nil
    end
    if a1.Parent == v1.anchor then
        a1.Parent = nil
    end
    v1.tracker:Destroy()
    v1.anchor:Destroy()
end

function u26.Drop(a1) -- Line: 93 -- upvalues: dropFollower (val) -- types: a1: userdata
    dropFollower(a1, nil)
end

local function advance(a1) -- Line: 97
    -- upvalues: Player (val), LocalPlayer (val), u28 (val), dropFollower (val), chase (val)
    local v1 = Player.FindPrimaryPart(LocalPlayer)
    local Position = if not v1 then nil else v1.Position
    local v2 = nil
    local v3 = nil
    for i, j in u28, v2, v3 do
        v1 = false
        if i.Parent == j.anchor then
            v1 = j.anchor.Parent ~= nil
        end
        if not v1 then
            dropFollower(i, j.id)
        elseif j.model:IsDescendantOf(game) then
            if Position == nil then
                j.anchor.CFrame = j.model:GetPivot()
            else
                chase(j, Position, v4)
            end
        end
    end
end

function u26.MakeAnchor(a1, a2) -- Line: 115 -- upvalues: u25 (val) -- types: a1: string?, a2: userdata
    local Part = Instance.new("Part")
    for i, j in u25 do
        Part[i] = j
    end
    Part.Name = a1 or "SmartPromptPart"
    Part.CFrame = a2
    Part.Parent = workspace
    return Part
end

function u26.Add(a1, a2, a3, a4, a5) -- Line: 127
    -- upvalues: u26 (val), u30 (ref), u28 (val), dropFollower (val), u29 (ref), RunService (val), advance (val)
    u26.Drop(a1)
    u30 = u30 + 1
    local u11 = u30
    local v1 = {
        id = u11,
        model = a2,
        anchor = a3,
        tracker = a4,
        connections = {},
        standoff = a5.SurfaceOffset or 0.75,
        rate = a5.FollowSpeed or 18,
        range = math.max(a5.TrackDistance or 7, a1.MaxActivationDistance),
    }
    u28[a1] = v1

    local function dropCurrent() -- Line: 150 -- upvalues: dropFollower (upval), a1 (val), u11 (val)
        dropFollower(a1, u11)
    end

    v1.connections = {
        a1.Destroying:Connect(dropCurrent),
        a2.Destroying:Connect(dropCurrent),
        (a1.AncestryChanged:Connect(function() -- Line: 157 -- upvalues: a1 (val), a3 (val), dropFollower (upval), u11 (val)
            if a1.Parent ~= a3 then
                dropFollower(a1, u11)
            end
        end)),
    }
    if a3.Parent == nil then
        dropFollower(a1, u11)
    else
        a1.Parent = a3
    end
    if u28[a1] == v1 and u29 == nil then
        RunService.Heartbeat:Connect(advance)
    end
    local u57 = true
    return function() -- Line: 175 -- upvalues: u57 (ref), dropFollower (upval), a1 (val), u11 (val)
        if u57 then
            u57 = false
            dropFollower(a1, u11)
        end
    end
end

return u26